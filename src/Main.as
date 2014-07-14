package {

import Solider;
import flash.display.Bitmap;
import flash.display.BitmapData;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class Main extends Sprite {
    private var arena : BattleField;
    private var canvas : BitmapData;

    private var calculate:Timer = new Timer( 5 );
    private var draw:Timer = new Timer( 25 );
    private var fight:Timer = new Timer( 5000 );

    private var RED : Army;
    private var BLUE : Army;

    public function Main() {
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        RED = new Army( 4000 )
        RED.color = 0xFF0000;
        RED.x = 170;
        RED.y = 150;

        BLUE = new Army( 4000 )
        BLUE.color = 0x0000FF;
        BLUE.x = 130;
        BLUE.y = 150;

        arena = new BattleField( 300, 300, [ RED, BLUE ] );

        var b : Bitmap;
        addChild( b = new Bitmap( canvas = new BitmapData( 300, 300 ) ) );
        b.height = b.width = 600;

        calculate.addEventListener(TimerEvent.TIMER, Calculate );
        calculate.start();

        draw.addEventListener(TimerEvent.TIMER, Redraw );
        draw.start();

        fight.addEventListener(TimerEvent.TIMER, Fight );
        fight.start();
    }

    private function Fight(event:TimerEvent):void {
        var v = RED.x;
        RED.x = BLUE.x;
        BLUE.x = v;
    }

    private function Redraw(event:TimerEvent):void {
        canvas.setPixels( canvas.rect, arena.pixels );
    }

    private function Calculate(event:TimerEvent):void {
        arena.Step();
    }
}
}
