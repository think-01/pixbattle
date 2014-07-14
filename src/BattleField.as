/**
 * Created with IntelliJ IDEA.
 * User: wizzard
 * Date: 14.07.14
 * Time: 10:34
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Graphics;
import flash.utils.ByteArray;

public class BattleField {
    public var board : Vector.<Cell> = new Vector.<Cell>();
    private var width : uint;
    private var height : uint;

    public function BattleField( w : uint, h: uint, a : Array ) {
        width = w;
        height = h;

        board = new Vector.<Cell>();
        while( board.length < width*height ) board.push( new Cell() );

        var n : uint = 0;
        for( var i in a )
            for( var j in a[i].soliders )
                board[n++].solider = a[i].soliders[j];

        board.sort( shuffle );
        board.forEach( IndexBoard );
    }

    private function IndexBoard( cell:Cell, index:int, vector:Vector.<Cell> ):void
    {
        var y : uint = Math.floor( index/width );
        var x = index - y*width;
        cell.siblings.push( x>0         ? board[index-1]        : new Cell( true ) );
        cell.siblings.push( y>0         ? board[index-width]    : new Cell( true ) );
        cell.siblings.push( x<width-1   ? board[index+1]        : new Cell( true ) );
        cell.siblings.push( y<height-1  ? board[index+width]    : new Cell( true ) );

        cell.index = index;
        cell.x = x;
        cell.y = y;
    }

    private function shuffle( a:Cell, b:Cell ): int
    {
        var r : Number = Math.random();
        if( r>0.5 ) return 1;
        if( r<0.5 ) return -1;
        return 0;
    }

    public function Step() : void
    {
        for( var index : uint = 0; index<board.length; index++ )
        {
            var cell : Cell = board[index];
            if( cell.solider == null ) continue;
            var i : uint = cell.solider.Move( cell );
            if( i != cell.index )
            {
                board[i].solider = cell.solider;
                cell.solider = null;
            }
        }
    }

    public function get pixels() : ByteArray
    {
        var b : ByteArray = new ByteArray();
        for( var i in board ) b.writeUnsignedInt( board[i].pixel );
        b.position = 0;
        return b;
    }
}
}
