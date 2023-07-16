# packagekit-d

A binding to the internals of [PackageKit](https://github.com/PackageKit/PackageKit) - allowing you to create
new backends in the D programming language.

This has been created to enable encapsulation of the `eopkg` and `moss` package managers with graphical
Linux applications.

## Integration of packagekit-d

Your main project should set the following in `dub.json`:

```json
	"targetType": "dynamicLibrary"
	"dflags-ldc": [
		"--checkaction=C",
		"--fvisibility=hidden",
		"-L-Wl,--version-script=symbols.ver"
	],
	"targetName": "pk_backend_$BACKEND_NAME"
```

Copy the `symbols.ver` linker script into your project root.


In your main library `.d` file, you must implement the runtime hookup by providing
an implementation of this method:

```d
export extern (C) Plugin packagekit_d_plugin_create()
{
	// return new MyPlugin();
}
```

You will need to derive from the `packagekit.plugin` abstract class.