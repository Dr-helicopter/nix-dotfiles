#!/usr/bin/env bash

home-manager switch --impure --flake "$HOME"/.config/home-manager#"$(uname -n)"

