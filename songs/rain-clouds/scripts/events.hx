import flixel.util.FlxColor;

var note:FunkinSprite;
var noteTween:FlxTween;
final NOTE_X:Float = 120;
final TWEEN_LENGTH:Float = 0.7;

function onCreate() {
	note = new FunkinSprite(0, 150, true);
	note.frames = Paths.getPath('game/stages/clubRoom/events/notes', 'animated');
	note.addAnim('sayo', 'SayoNote', 24);
	note.addAnim('bf', 'BFNote', 24);
	note.addAnim('cow', 'CowNote', 24);
	note.addAnim('gf', 'GFNote', 24);
	note.playAnim('sayo');
	note.cameras = [camHUD];
	note.visible = false;
	add(note);
}

var black:FlxSprite;

function onCountdown() {
	black = new FlxSprite().makeGraphic(FlxG.width * 5, FlxG.height * 5, FlxColor.BLACK);
	black.scrollFactor.set();
	black.screenCenter();
	add(black);
}

function onNote(isAppear:Bool, ?anim:String) {
	if (anim != null)
		note.playAnim(anim, true);
	var isLeft:Bool = note.animation.curAnim.name == 'bf' || note.animation.curAnim.name == 'gf';
	if (noteTween != null)
		noteTween.cancel();
	if (isAppear) {
		note.visible = true;
		note.x = isLeft ? -(100 + note.width) : (FlxG.width + 100);
		noteTween = FlxTween.tween(note, {x: isLeft ? NOTE_X : (FlxG.width - note.width - NOTE_X)}, TWEEN_LENGTH, {
			ease: FlxEase.circOut
		});
	} else {
		noteTween = FlxTween.tween(note, {x: isLeft ? -(100 + note.width) : (FlxG.width + 100)}, TWEEN_LENGTH, {
			ease: FlxEase.circOut,
			onComplete: function(twn:FlxTween) {
				note.visible = false;
			}
		});
	}
}

function onStepHit(step:Int) {
	switch (step) {
		case 1:
			FlxTween.tween(black, {alpha: 0}, 1, {ease: FlxEase.circOut});
		case 322:
			onNote(true, 'sayo');
		case 350:
			onNote(false);
		case 356:
			onNote(true, 'bf');
		case 380:
			onNote(false);
		case 386:
			onNote(true, 'cow');
		case 414:
			onNote(false);
		case 420:
			onNote(true, 'gf');
		case 448:
			onNote(false);
	}
}
