sudo chmod -R 777 ./data/backend/peppol
sudo rm -rf ./data/sftp
sudo mkdir -p ./data/sftp/dev && sudo chmod -R 777 ./data/sftp/dev
ssh-keygen -t ed25519 -f ./data/sftp/dev/ssh_host_keys </dev/null

# to do after
# docker compose exec sftp chown -R 1001:1001 /home/peppol/expenses /home/peppol/invoices
# docker compose exec -it sftp chown -R 1001:1001 /home/peppol/invoices/Succes
