# Eluna for Project SkyFire

This separate project owns the optional Eluna runtime: Lua engine sources,
Lua dependency, configuration, example scripts, extensions, and installation.
The core has no Eluna build definition or startup call. The module registers a
WorldScript through the normal generated module loader.

## Add to a core checkout

The module must occupy modules/mod-eluna because that directory name determines
its generated loader function. With a core checkout that includes the pinned
submodule, run:

```sh
git submodule update --init --recursive modules/mod-eluna
```

For a compatible core without that submodule, clone it manually:

```sh
git clone https://github.com/ProjectSkyFire-Modules/Eluna.git modules/mod-eluna
```

This requires the SkyFire module extraction changes: module-owned CMake hooks,
removal of the built-in Eluna startup, and the public database field-type
accessor. Older cores with built-in Eluna cannot use this as a drop-in module.
This is a compiled worldserver module, not a separate server daemon.

## Build and install

Configure with -DMODULES=ON -DMOD_ELUNA=ON, then build and INSTALL normally.
MOD_ELUNA defaults to OFF. MODULES=OFF, MOD_ELUNA=OFF, or removing this
module folder excludes the runtime and its Lua dependency. The old ELUNA
CMake option is accepted as a migration default; an explicit MOD_ELUNA wins.

INSTALL supplies eluna.conf.dist beside worldserver.conf.dist and stages
lua_scripts with the existing startup example and extensions. Windows builds
also stage these beside the server binaries. Existing eluna.conf is not
overwritten.

Copy eluna.conf.dist to eluna.conf beside the active worldserver.conf
(including a custom path selected with -c), then set Eluna.Enabled = 1.
The module loads this file during the normal configuration hook and starts Lua
after C++ script registration. Lua world events and timed events keep using the
existing WorldScript bridge.

Eluna.ScriptPath defaults to lua_scripts, relative to the worldserver
working directory. Linux INSTALL uses CONF_DIR/lua_scripts; set an absolute
script path if the process runs from another directory.

## Migration

Move Eluna.Enabled and Eluna.ScriptPath from worldserver.conf to
eluna.conf. Existing settings in worldserver.conf are still read when the
module config is absent. The shipped module config uses the same [worldserver]
section so its values override the old settings.

Restart worldserver to enable or disable the runtime. Config reload reloads the
module config and dispatches the existing Lua config event, but does not tear
down or create the Lua engine mid-session. Script-path changes take effect on
the next engine restart. This extraction preserves the existing Lua API and
hook coverage; it does not add new gameplay hooks.

## Validation

Ubuntu CI builds and installs the enabled module and checks its config and Lua
assets. For runtime acceptance, enable the module, confirm the startup smoke
message, exercise a timed/world event, reload configuration, and restart with
the module disabled. Run a separate core build with MODULES=OFF to verify the
standalone boundary.
