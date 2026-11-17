function onIconAnim() {
    if (iconP1 != null) {
        if (playStateConfig.health < 0.4) {
            iconP1.playAnim('losing');
        } else if (playStateConfig.health > 1.6) {
            iconP1.playAnim('winning');
        } else {
            iconP1.playAnim('normal');
        }
    }

    if (iconP2 != null) {
        if (playStateConfig.health > 1.6) {
            iconP2.playAnim('losing');
        } else if (playStateConfig.health < 0.4) {
            iconP2.playAnim('winning');
        } else {
            iconP2.playAnim('normal');
        }
    }

    return true;
}