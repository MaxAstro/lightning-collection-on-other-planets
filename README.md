# Scrap Reprocessor

In an attempt to make late-stage Fulgora builds more interesting and reward the player for mastering the planet, this mod adds a powerful new option for processing scrap once you have electromagnetic science packs. The mod's goal is to introduce new and interesting automation challenges that reward smart setups by giving higher yields than normal scrap recycling.

## Features

The scrap reprocessor is a beastly scrap-devouring machine. Belt-fed and able to keep up with a full red belt at regular speed, it pressure washes and automatically sorts scrap. This sorted scrap has a higher recycler yield, or can be fed into another reprocessor for even more output. The waste water from the process - a delightful slurry of Fulgoran minerals - can also be separated at a chemical plant into stone, iron ore, reclaimed water, and holmium solution, providing a higher rate of solution than simply recycling scrap for holmium ore.

Better yet, the reprocessor's sorting process often turns up higher quality bits of scrap - the building has an innate quality bonus, even if no modules are installed. It also has a full six module slots and unlike the recycler is able to use productivity modules (although many setups will want to use quality modules, since the reprocessor excels at that).

Of course, this new process is not without its challenges. The reprocessor is power-hungry compared to recyclers and although its processes are on the whole water-neutral as long as you process the waste slurry, it doesn't output ice so you will need to import the initial water (and any water your other machines need) from elsewhere. The innate quality bonus can be a curse in disguise, too, since the reprocessor's output has to be quality-sorted or your machines will jam.

The reprocessor is also a purpose-built machine; while it is very good at its job, it is not capable of general recycling like the recycler. It's scrap or nothing.

## Usage Notes

* Due to an engine limitation, the reprocessor's inbuilt loaders are not visible until the building is placed.
* When the machine is rotated or picked up, any items in the loaders are lost. I'm investigating a performant way to avoid this, but since the reprocessor's inputs and outputs are all filtered the loss should be minor.
* Many features of the mod can be customized in settings, including tweaking the reprocessor's outputs and quality bonus.
* The reprocessor does not output solid fuel. This is intentional. There's a whole ocean of the stuff.
* By default the reprocessor technology has Quality 3 as an additional prerequisite. If you set the option to remove its innate quality bonus, this prereq is removed. This also removes quality 3 modules from the reprocessor's crafting recipe.

## Mod Developer Notes

If you make a mod that adds additional recipes to the reprocessor, its innate loaders will automatically detect the recipe and set their filters accordingly. However, if your recipe has more than one solid input or more than three solid outputs, they will give up and revert to unfiltered mode. This generally makes the machine harder to use and is not suggested.

Eventually I may implement support for split-lane filtering so a larger number of ingredients/products are supported.

## Special Thanks
-Scrap reprocessor art modified from original "Chemical Stager" building by [hurricane046](https://mods.factorio.com/user/hurricane046)
-Huge thanks to Lyra on the Factorio discord for getting me started with making compound entities
-Also thanks [PennyJim](https://mods.factorio.com/user/pennyjim), [justarandomgeek](https://mods.factorio.com/user/justarandomgeek) and others for general coding assistance
-Loader artwork from [Loaders Modernized](https://mods.factorio.com/mod/loaders-modernized)