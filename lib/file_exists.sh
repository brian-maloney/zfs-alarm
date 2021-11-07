file_exists () {
  source ./PKGBUILD
  filename="${pkgname}-${pkgver}-${pkgrel}-aarch64.pkg.tar.xz"
  echo "Checking for $filename"
  retcode=$(curl -o /dev/null -s -Iw '%{http_code}' "https://aur.vond.net/aarch64/$filename")
  if [[ "$retcode" -lt "300" ]]
  then
    return
  fi

  false
}
