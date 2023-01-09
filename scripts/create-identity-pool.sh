#!/bin/bash

export PROJECT_ID="secret-medium-373003"
export IDENTITY_POOL="googlemon-pool22"
export IDENTITY_PROVIDER="googlemon-identity-provider"
export SERVICE_ACCOUNT="googlemon-service-account"
# export SERVICE_ACCOUNT="github-actions-googlemon"
export REPO="monaws-innovations/smri-gcp-terraform"

gcloud iam service-accounts create $SERVICE_ACCOUNT \
  --project "${PROJECT_ID}"

gcloud services enable iamcredentials.googleapis.com \
  --project "${PROJECT_ID}"

gcloud iam workload-identity-pools create $IDENTITY_POOL \
  --project="${PROJECT_ID}" \
  --location="global" \
  --display-name="$IDENTITY_POOL"

WORKLOAD_IDENTITY_POOL_ID=$(gcloud iam workload-identity-pools describe $IDENTITY_POOL \
  --project="${PROJECT_ID}" \
  --location="global" \
  --format="value(name)") 

gcloud iam workload-identity-pools providers create-oidc $IDENTITY_PROVIDER \
  --project="${PROJECT_ID}" \
  --location="global" \
  --workload-identity-pool=$IDENTITY_POOL \
  --display-name="$IDENTITY_POOL provider" \
  --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository" \
  --issuer-uri="https://token.actions.githubusercontent.com"

gcloud iam service-accounts add-iam-policy-binding "${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/${WORKLOAD_IDENTITY_POOL_ID}/attribute.repository/${REPO}"

gcloud iam service-accounts add-iam-policy-binding "${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.securityAdmin" \
  --member="serviceAccount:${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com"

gcloud iam service-accounts add-iam-policy-binding "${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.securityReviewer" \
  --member="serviceAccount:${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com"

gcloud iam service-accounts add-iam-policy-binding "${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com" \
  --project="${PROJECT_ID}" \
  --role="roles/owner" \
  --member="serviceAccount:${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com"

gcloud iam workload-identity-pools providers describe $IDENTITY_PROVIDER \
  --project="${PROJECT_ID}" \
  --location="global" \
  --workload-identity-pool=$IDENTITY_POOL \
  --format="value(name)"