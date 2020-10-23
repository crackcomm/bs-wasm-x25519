(** OCaml (BuckleScript) bindings to lights0123/wasm-x25519. *)

module KeyPair = struct
  type t = string * string

  (** Returns public part of key pair. *)
  let public_of ((_, public) : t) = public

  (** Returns secret part of key pair. *)
  let secret_of ((secret, _) : t) = secret
end

(** Initialize WASM asynchronously. *)
external load : string -> unit Js.Promise.t = "load"
  [@@genType.import "wasm-x25519", "default"]

(** Generates a keypair returning secret and public keys. *)
external generate_keypair : unit -> KeyPair.t = "generate_keypair"
  [@@genType.import "wasm-x25519"]

external diffie_hellman : string -> string -> string = "diffie_hellman"
  [@@genType.import "wasm-x25519"]

(** Calculate a shared secret from one party's secret key and another party's public key. *)
let diffie_hellman ~secret ~public = diffie_hellman secret public

(** Encodes as standard base64. *)
external base64_encode : Js.Typed_array.Uint8Array.t -> string = "base64_encode"
  [@@genType.import "wasm-x25519"]

(** Decodes a standard base64. *)
external base64_decode : string -> Js.Typed_array.Uint8Array.t = "base64_decode"
  [@@genType.import "wasm-x25519"]
