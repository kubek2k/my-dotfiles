{ installMacApplicationFromZip, fetchurl, ... }: installMacApplicationFromZip rec {
  name = "Focus";
  version = "1.10.4";
  sourceRoot = "Focus.app";
  src = fetchurl {
    url = https://heyfocus.com/uploads/Focus-v1.10.4.zip;
    sha256 = "06mc3mwxyj8ji5s4pw9gq9a868h4bp4xrnpd3101vpz96s00fm8i";
  };
  description = "Focus is an app to get focus when you need to";
  homepage = https://heyfocus.com;
}
