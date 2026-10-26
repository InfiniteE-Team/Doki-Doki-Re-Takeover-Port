import flixel.group.FlxGroup.FlxTypedGroup;

var funnybubbles:Bool = false;
var particleGroup:FlxTypedGroup<FunkinSprite>;

function postCreate() {
	if (particleGroup == null) {
		particleGroup = new FlxTypedGroup();
		add(particleGroup);
	}
}

function spawnBubbles() {
	var scale:Float = FlxG.random.float(0.5, 0.745);

	var parti:FunkinSprite = new FunkinSprite(FlxG.random.int(-200, 3000), 1000, true);
	parti.loadGraphic(Paths.getPath('game/stages/clubRoom/events/bubble', 'image'));
	parti.scale.set(scale, scale);
	particleGroup.add(parti);

	FlxTween.tween(parti, {y: parti.y - 2000, alpha: 0}, FlxG.random.float(12, 23), {
		onComplete: function(tween:FlxTween) {
			parti?.kill();
			parti = null;
		}
	});
}

function onStepHit(step:Int) {
	if (funnybubbles && step % 2 == 0)
		spawnBubbles();

	switch (step) {
		case 592:
			chars.playSpecialAnim('gf-redoki', 'countdownThree');
		case 596:
			chars.playSpecialAnim('gf-redoki', 'countdownTwo');
		case 600:
			chars.playSpecialAnim('gf-redoki', 'countdownOne');
		case 604:
			chars.playSpecialAnim('gf-redoki', 'countdownGo');
		case 630:
			funnybubbles = true;
		case 864:
			funnybubbles = false;
			endBubblesFast();
	}
}

function onDestroy():Void {
	funnybubbles = false;
	endBubblesFast();
	particleGroup = null;
}

function endBubblesFast() {
	if (particleGroup == null)
		return;

	for (particle in particleGroup) {
		if (particle != null) {
			FlxTween.cancelTweensOf(particle);

			particle?.kill();
			particleGroup.remove(particle);
			particle = null;
		}
	}
}
