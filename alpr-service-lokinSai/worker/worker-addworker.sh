gcloud compute disks snapshot worker --project=lab5-vm --snapshot-names=worker-snapshot --zone=us-central1-b --storage-location=us

gcloud compute --project "lab5-vm" disks create "worker2" --size "10" --zone "us-central1-b" --source-snapshot "worker-snapshot" --type "pd-standard"

gcloud beta compute --project=lab5-vm instances create worker2 --zone=us-central1-b --machine-type=n1-standard-1 --subnet=default --network-tier=PREMIUM --maintenance-policy=MIGRATE --service-account=205072196872-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --disk=name=worker2,device-name=worker2,mode=rw,boot=yes,auto-delete=yes --reservation-affinity=any