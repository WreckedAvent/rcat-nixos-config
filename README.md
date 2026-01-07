# rileycat nixos configuration

all of the systems i've moved to nix live here.

> [!Note]
> this configuration is meant to be approachable and be closer to 
> a lightly, if productively, configured set of hosts rather than
> any one especially riced out host. <br />
> this means biasing towards helix over nixvim, kde/cosmic over hyprland,
> and not pinning down every single piece of configuration in nix.

#### list of hosts

* `blackjack` - generic gaming computer, nvidia graphics and intel cpu (nixos)
* `rileyrose` - microsoft surface laptop, 7th gen (w11 w/nixos-wsl)
* `silverwolf` - framework 13 laptop, AMD 2nd gen (nixos)
* `work-mac` - apple macbook pro, 1st gen (macos w/darwin-nixos)

#### how to read

<details open>
<summary>for a total neophyte</summary>

don't worry yet about the flake pieces.

you can look at the `hardware.nix` and `conf.nix` of each host and compare it to your own.

if you see a configuration like `rcat.coding`, then look in the `hosts/coding` file to
find out what that does (these are nixos modules).

 what you see is what you get.
</details>

<details>
<summary>if you care about home-manager</summary>
this configuration uses hm in both a standalone and as a nixos module, depending on the host.

`home.nix` are "vanilla" home manager modules without `extraSpecialArgs` set.
</details>

<details>
<summary>if you care about flakes</summary>

this configuration uses flake-parts instead of flake-util.

each `default.nix` in a host or user's folder is meant to be directly (and explicitly) imported by `flake.nix`.

 i also believe flake inputs should stay in flake land and not "escape" into `conf.nix` or `home.nix`.
</details>

#### how to install

preferably, you do not.

each `index.nix` in a given host is meant to be *tightly* tied to that host.

you are perfectly welcome to copy and paste every bit of code and adapt it to yours,
however, and i would even encourage adding a folder for your own host and copy-pasting
the results of a fresh `generate-nixos-config` into there.
