/**
 * Created with IntelliJ IDEA.
 * User: wizzard
 * Date: 14.07.14
 * Time: 10:03
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Sprite;
import flash.geom.Point;

public class Solider{
    private var stamina :       uint;
    public var army : Army;

    public function Solider( a : Army ) {
        army = a;
        stamina = 50;
    }

    public function Move( cell:Cell ) : uint
    {
        var candidates : Array = [];
        var dx = cell.x - army.x;
        var dy = cell.y - army.y;

        if( dx > 0 ) candidates.push(0);
        if( dx < 0 ) candidates.push(2);
        if( dx == 0 ) candidates.push( Math.random() > 0.5 ? 0 : 2 );

        if( dy > 0 ) candidates.push(1);
        if( dy < 0 ) candidates.push(3);
        if( dy == 0 ) candidates.push( Math.random() > 0.5 ? 1 : 3 );

        if( Math.abs(dx) < Math.abs(dy) ) candidates.reverse();

        candidates.push( Math.floor( 4*Math.random() ) );

        for( var i: uint = 0; i<candidates.length; i++ )
        {
            var candidate : Cell = cell.siblings[ candidates[i] ];
            if( candidate.solider == null )
            {
                if( candidate.isObstacle ) continue;
                else return candidate.index;
            }
            else
            {
                if( candidate.solider.army == army ) continue;
                else
                {
                    if( candidate.solider.kill( this ) ) candidate.solider = null;
                    return cell.index;
                }
            }
        }
        return cell.index;
    }

    public function kill( attacker:Solider ):Boolean
    {
        if( Math.random() > 0.5 ) stamina--;
        return stamina <= 0;
    }
}
}
