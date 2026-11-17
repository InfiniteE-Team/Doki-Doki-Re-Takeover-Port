var table:FunkinSprite;

function onCreate() {
	table = new FunkinSprite(0, 0, true);
	table.frames = Paths.getPath('game/stages/clubRoom/events/table', 'animated');
	table.addAnim('RainTable', 'RainTable', 24, true);
	table.addAnim('SadTable', 'SadTable', 24, true);
	table.cameras = [camHUD];
	table.visible = false;
	table.scrollFactor.set(0, 0);
	add(table);
}

function onStepHit(step:Int) {
	switch (curSong) {
		case 'My Confession (Re-Takeover)':
			switch (step) {
				case 864:
					table.playAnim('SadTable');
					table.visible = true;
				case 880:
					table.visible = false;
			}
		case 'Rain Clouds (Re-Takeover)':
			switch (step) {
				case 656:
					table.playAnim('RainTable');
					table.visible = true;
				case 672:
					table.visible = false;
			}
	}
}

function onDestroy() {
    if (table != null)
        table.destroy();
    table = null;
}