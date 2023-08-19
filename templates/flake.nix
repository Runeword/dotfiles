{
  outputs = { self }: {
    templates = {
      js.path = ./js;
      js.description = "js";
      js.welcomeText = "js";

      proto.path = ./proto;
      proto.description = "proto";
      proto.welcomeText = "proto";

      firebase.path = ./firebase;
      firebase.description = "firebase";
      firebase.welcomeText = "firebase";

      go.path = ./go;
      go.description = "go";
      go.welcomeText = "go";

      rust.path = ./rust;
      rust.description = "rust";
      rust.welcomeText = "rust";
    };
  };
}
