# rileycat nixos configuration

A (relatively) simple flake-(parts)-based nixos configuration for all of the hosts I've moved to nix in my home lab.

# for beginners

Welcome! This configuration is meant to be approachable while not being limited due to accessibility.

* You can read each system's `conf.nix` and `hardware.nix` and compare it to your own.
* If you have home manager installed, you can additionally look at `home.nix` files and do the same.
* If your configuration is flake-based *and* you are feeling ambitious, you can look at the respective `default.nix` files.
* You can ignore the rest of this readme.

# layout

The general idea is simple: each piece is more re-usable as you go down.
The edges should not need to deal with flake-specific problems, such as specifying what system they get their packages from.

* `flake.nix` - the *flake's* entry point.
  * The entire configuration with all imports and everything included. Not designed to be re-used.
  
* `**/*/default.nix` - a *flake parts'* entry point.
  * A smaller, more specialized part of the flake. Given the right inputs, these can be re-used.

* `**/*.flake-part.nix` - a *flake part*.
  * The smallest piece of a flake. Only requiring a few specific inputs, these are reusable. 

* `hosts/*.nix` - a *nixos module*.
  * Small chunks of code for nixos configurations. All namespaced to `rcat`. Import and re-use freely.

* `users/*.nix` - a *home manager module*.
  * Small chunks of code for home configurations. All namespaced to `rcat`. Import and re-use freely.

* `hosts/*/{conf, hardware}.nix` - a *vanilla nixos configuration*.
  * Designed to be drop-in replacements for `nixos-generate-config`. These should not rely on flake inputs.

* `users/*/home.nix` - a *vanilla home configuration*.
  * No tool generates these, but these should not rely on flake inputs.
