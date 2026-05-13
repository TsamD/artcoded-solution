# usage: bash release.sh 2026.5.14
git checkout main
git pull

git tag $1
git commit -m "version $1"

echo "push tag $1..."
git push origin $1

git push

echo "done."