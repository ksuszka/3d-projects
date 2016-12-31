/*
 * Generates a 3D model of randomized terrain.
 *
 * @param sx - the size of generated model along x axis.
 * @param sy - the size of generated model along y axis.
 * @param base_h - the minimal height of generated model.
 * @param steps - a vector of generation parameters. Each element of that vector adds additional layer of details.
 *                Single element can be a 2 element vector [s, w] or a single integer "s" (in that case "w" is
 *                assumed to be 1). "s" sets resolution of the layer, a new random number is used for the height
 *                every "s" units. "w" sets the weight of the layer.
 * @param seed - random generator seed. If unset then random value is used.
 * @return A 3D block of randomized terrain. 
 */
module terrain(sx,sy,base_h=1,steps=[[1,0.2],3,5,7,11],seed=undef) {
    real_seed = seed*0 == 0 ? seed : rands(0,1000000,1)[0];
    function sumv_imp(v,i,acc) = i<0 ? acc : sumv_imp(v, i-1, acc + v[i]);
    function sumv(v) = sumv_imp(v,len(v)-1,0);
    function height(x,y) = sumv([
        for(step=steps)
        let(s=len(step)>=0 ? (len(step)>0 ? step[0] : 0) : step)
        let(w=len(step)>1 ? step[1] : 1)
        terrain_height(x,y,s,real_seed)*w]) + base_h;
    p1 = [[0,0,0],[sx,0,0],[0,sy,0],[sx,sy,0]];
    p2 = [ if (sy>=0 && sx>=0)
            for(y=[0:sy],x=[0:sx] )
                [x,y,height(x,y)] ];
    p = concat(p1,p2);
    function f_idx(x,y) = len(p1)+y*(sx+1)+x;
    f1 = [ if (sy>0 && sx>0)
            for(y=[0:sy-1],x=[0:sx-1])
                [ f_idx(x,y), f_idx(x,y+1), f_idx(x+1,y) ] ];
    f1b = [ if (sy>0 && sx>0)
            for(y=[0:sy-1],x=[0:sx-1])
                [ f_idx(x,y+1), f_idx(x+1,y+1), f_idx(x+1,y) ] ];
    f2 = [ if (sx>0)
            concat([ for(x=[sx:-1:0]) len(p1)+x+sy*(sx+1) ], [2,3]) ];
    f3 = [ if (sx>0)
            concat([ for(x=[0:sx]) len(p1)+x ], [1,0]) ];
    f4 = [ if (sy>0)
            concat([ for(y=[sy:-1:0]) len(p1)+y*(sx+1) ], [0,2]) ];
    f5 = [ if (sy>0)
            concat([ for(y=[0:sy]) len(p1)+sx+y*(sx+1) ], [3,1]) ];
    f6 = [ if (sy>0 && sx>0)
            [0,1,3,2] ];
    f = concat(f1,f1b,f2,f3,f4,f5,f6);
    polyhedron(points=p,faces=f);
}

/*
 * Generates terrain height value for given coordinates.
 *
 * @param x - x coordinate.
 * @param y - y coordinate.
 * @param steps - terrain resolution factor.
 * @param seed - random generator seed.
 * @return The height of the terain at (x,y) coordinates.
 */
function terrain_height(x,y,steps=1,seed=0) = 
    let(cx=floor(x/steps),
        cy=floor(y/steps),
        sx=_terrain_rem(x/steps),
        sy=_terrain_rem(y/steps),
        h00=_terrain_cell_height(cx,cy,seed),
        h01=_terrain_cell_height(cx+1,cy,seed),
        h10=_terrain_cell_height(cx,cy+1,seed),
        h11=_terrain_cell_height(cx+1,cy+1,seed))
    _terrain_interpolate2d(h00,h01,h10,h11,sx,sy);

// http://stackoverflow.com/a/919661
function _terrain_pairing_normalize(a) = a >= 0 ? a*2 : -a*2-1;
function _terrain_pairing(i1,i2) = 
    let(n1=_terrain_pairing_normalize(i1),
        n2=_terrain_pairing_normalize(i2))
    (n1 + n2)*(n1 + n2 + 1)/2 + n2;

function _terrain_rem(a) = a-floor(a);
     
function _terrain_interpolate2d(h00,h01,h10,h11,sx,sy) = 
    (h00+(h01-h00)*sx)*(1-sy) + 
    (h10+(h11-h10)*sx)*sy;

function _terrain_cell_height(x,y,seed) =
    rands(0,1,1,_terrain_pairing(x,y)+seed)[0];
