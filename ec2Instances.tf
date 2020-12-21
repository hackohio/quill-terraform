resource "aws_instance" "quillTerraformDB" {
  ami           = "ami-04f434dba3a30ffae"
  instance_type = "t2.micro"

  key_name               = "hack2020"
  vpc_security_group_ids = [aws_security_group.quillTerraformDBSG.id]

  subnet_id = module.vpc.intra_subnets[0]

  tags = {
    Name = "quillTerraformDB"
  }
}

resource "aws_instance" "quillTerraformServer" {
  ami           = "ami-085925f297f89fce1"
  instance_type = "t2.micro"

  key_name               = "hack2020"
  vpc_security_group_ids = [aws_security_group.quillTerraformServerSG.id]

  subnet_id = module.vpc.public_subnets[0]

  user_data = <<EOT
#! /bin/bash
echo "launch script...."
sudo apt update
sudo apt install nginx -y
sudo rm /etc/nginx/sites-enabled/default
echo "server {                                          
                                                  
        server_name reghackohio.com;              
                                                  
        location / {                              
                proxy_pass http://localhost:3000; 
        }                                         
}" > /etc/nginx/sites-enabled/reghackohio.com
sudo systemctl restart nginx

sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot -y
sudo apt-get update
sudo apt-get install certbot python3-certbot-nginx -y

sudo apt install git-all -y
git clone https://github.com/pkshah2017/quill.git /home/ubuntu/quill
cd /home/ubuntu/quill
git checkout ${var.GITHUB_BRANCH}
cp .env.template .env
export JWT_SECRET=${var.JWT_SECRET}
export ADMIN_EMAIL=${var.ADMIN_EMAIL}
export ADMIN_PASS=${var.ADMIN_PASS}
export EMAIL_PASS=${var.EMAIL_PASS}
export DATABASE=mongodb://${var.DB_QUILL_USERNAME}:${var.DB_QUILL_PASSWORD}\@${aws_instance.quillTerraformDB.private_ip}:27017/Quill?authSource=Quill

sudo apt install curl -y
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install nodejs -y
sudo apt-get install -y make
sudo apt-get install -y g++
sudo npm i
sudo npm i -g gulp-cli

EOT

  tags = {
    Name = "quillTerraformServer"
  }
}
