set -e

# Check secret
SECRET=$(head -n 1 SOLUTION | md5sum)

if [ "$SECRET" != "b326212055e5c61bfb292d47046215f8  -" ]
then
  echo "Invalid secret in the SOLUTION file."
  exit 1
fi

wget https://alonitac.github.io/DevOpsTheHardWay/linux_project/secretGenerator.tar.gz
tar -xf secretGenerator.tar.gz
cp yourSolution.sh src/yourSolution.sh
echo "q" > src/CONTENT_TO_HASH

cd src
bash yourSolution.sh

if [ ! -d secretDir ]
then
  echo "Directory secretDir is missing"
  exit 1
fi

if [ ! -f secretDir/.secret ]
then
  echo "File secretDir/.secret is missing"
  exit 1
fi

SECRET=$(head -n 1 secretDir/.secret)

if [ "$SECRET" != "c3be117041a113540deb0ff532b19543  -" ]
then
  echo "Failed to generate a successful secret"
  exit 1
fi

echo "Well Done! you've passed all tests"
