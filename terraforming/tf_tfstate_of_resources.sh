for i in `cat resoures_file`;
do
  mkdir $i;
  cd $i;
  terraform init;
  terraforming $i>$i.tf;
  terraforming $i --tfstate>terraform.tfstate;
  cd ..;
done
