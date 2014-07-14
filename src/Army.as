/**
 * Created with IntelliJ IDEA.
 * User: wizzard
 * Date: 14.07.14
 * Time: 10:25
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Graphics;
import flash.geom.Point;

public class Army {
    public var soliders : Vector.<Solider> = new Vector.<Solider>();
    public var color : uint;

    public var x : uint;
    public var y : uint;

    public function Army( s : uint ) {
        for( var i : uint = 0; i<s; i++ )
            soliders.push( new Solider( this ) );
    }
}
}
