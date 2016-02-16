# mgicon

by [Matt Gemmell](http://mattgemmell.com/)


## What is it?

It's an OS X command-line tool to generate a PNG of the icon of a specified file, or of files with a given file-extension.


## What are its requirements?

A reasonably recent (as of early 2016) version of Mac OS X.


## What does it do?

It generates a PNG file of the icon of the specified input file, folder, app, disk, or other file-system object. You can choose the dimensions of the icon, and where to save the resulting image file.

Alternatively, you can specify a file-extension and you'll get the icon for a generic file with that extension, which will depend on which app on your system is the default handler for those files.


## How do I use it?

Just do `mgicon` on the command-line, specifying an input file and at least the `-o` flag with the place you want to save the resulting image file.

`mgicon ~/Desktop/my-input-file.txt -o ~/Pictures/my-new-icon-file.png`

You can also:

- Use the `-s` flag to specify the dimensions of the image. Just one parameter, which will be both the width and height: `-s 512`

- Use the `-x` flag to specify a file-extension (without the period), and you'll get the icon for files with that extension instead: `-x html`

- Use the `-v` flag to enable verbose output.

That's about it.


## If the input file has a custom icon in the Finder, will this tool return the custom icon?

Yes.


## What _doesn't_ it do?

Anything I've not explicitly said that it _does_ do.


## Who made it?

Matt Gemmell (that's me).

- My website is at [mattgemmell.com](http://mattgemmell.com)

- I'm on Twitter as [@mattgemmell](http://twitter.com/mattgemmell)

- This code is on github at [github.com/mattgemmell/mgicon](http://github.com/mattgemmell/mgicon)


## What license is the code released under?

The [MIT license](http://choosealicense.com/licenses/mit/).

If you need a difference license, feel free to ask. I'm flexible about this.


## Why did you make it?

Partly for fun, and partly to use with [Keyboard Maestro](https://www.keyboardmaestro.com), which is an OS X macro utility.


## Can you provide support?

Nope. If you find a bug, please fix it and submit a pull request via github.


## I have a feature request

Feel free to [create an issue](https://github.com/mattgemmell/mgicon/issues) with your idea.


## How can I thank you?

You can:

- [Support my writing](http://mattgemmell.com/support-me/).

- Check out [my Amazon wishlist](http://www.amazon.co.uk/registry/wishlist/1BGIQ6Z8GT06F).

- Say thanks [on Twitter](http://twitter.com/mattgemmell), I suppose.
