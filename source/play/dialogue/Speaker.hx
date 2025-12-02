package play.dialogue;

import util.FlxZSprite;
import flixel.FlxG;
import data.dialogue.SpeakerData;

class Speaker extends FlxZSprite
{
    public var dialogueSounds:Array<FlxSound>;
    public var globalOffsets:Array<Float>;
    public var data:SpeakerData;

    public function new(data:SpeakerData)
    {
        super();
        this.data = data;

        this.globalOffsets = data.globalOffsets;
        this.dialogueSounds = [];

        // Default graphic
        makeGraphic(1,1,0x00FFFFFF);
        zIndex = 10;
    }

    public function switchToExpression(exprName:String):Void
    {
        var expr = null;

        for (e in data.expressions)
            if (e.name == exprName)
                expr = e;

        if (expr == null) return;

        // No loadGraphic() allowed — must use frames or atlas
        if (expr.animation != null)
        {
            this.frames = Paths.getSparrowAtlas(expr.assetPath);
            this.animation.addByPrefix("play", expr.animation.name, expr.animation.fps);
            this.animation.play("play");
        }
        else
        {
            // Single-frame expression:
            var bmp = Paths.image(expr.assetPath);
            this.loadGraphic(bmp); // BUT MUST BE WRAPPED IN FlxZSprite
        }

        this.antialiasing = expr.antialiasing;

        this.scale.set(expr.scale, expr.scale);

        this.x += expr.offsets[0];
        this.y += expr.offsets[1];
    }
}
