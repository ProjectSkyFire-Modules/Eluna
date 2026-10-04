# Source provenance

This project extracts the Eluna integration previously shipped in
ProjectSkyfire/SkyFire_548, using main revision
e08629c325eb590519f621f95796412d5aec44e2 as the source baseline.

- src originated in src/server/game/LuaEngine.
- scripts and extensions originated in that engine directory.
- dep/lualib originated in the core's dep/lualib directory.
- Module selection, packaging, configuration loading, and startup ownership
  were added during extraction. Existing Lua APIs and hook coverage are retained.

Original copyright and license notices remain in the source files. The project
license is in LICENSE.md. The bundled Lua license is preserved in dep/lualib/lua.h;
StackTracePlus retains its separate extensions/StackTracePlus/LICENSE.

Historical changes before extraction remain available in the original core:
https://github.com/ProjectSkyfire/SkyFire_548
