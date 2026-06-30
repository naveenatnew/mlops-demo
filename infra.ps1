$RESOURCE_GROUP = "rg-mlops-demo"
$LOCATION = "centralindia"
$AKS_NAME = "aks-mlops-demo"

$IDENTITY_NAME = "id-gha-mlops"

az group create `
    --name $RESOURCE_GROUP `
    --location $LOCATION

az aks create `
    --resource-group $RESOURCE_GROUP `
    --name $AKS_NAME `
    --node-count 1 `
    --enable-cluster-autoscaler `
    --min-count 1 `
    --max-count 2 `
    --node-vm-size Standard_DS2_v2 `
    --network-plugin azure `
    --network-plugin-mode overlay `
    --generate-ssh-keys `
    --enable-oidc-issuer `
    --enable-workload-identity
az identity create `
    --resource-group $RESOURCE_GROUP `
    --name $IDENTITY_NAME

$CLIENT_ID = az identity show `
    --resource-group $RESOURCE_GROUP `
    --name $IDENTITY_NAME `
    --query clientId `
    -o tsv

$PRINCIPAL_ID = az identity show `
    --resource-group $RESOURCE_GROUP `
    --name $IDENTITY_NAME `
    --query principalId `
    -o tsv

$SUBSCRIPTION_ID = az account show --query id -o tsv

$CLIENT_ID
$PRINCIPAL_ID
$SUBSCRIPTION_ID

