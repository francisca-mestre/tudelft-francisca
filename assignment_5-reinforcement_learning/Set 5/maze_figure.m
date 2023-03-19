function maze_figure (V)

grey_states = [1:7, 8, 14, 15, 17, 18, 20, 21, 22, 28, 29, 31:33, 35, 36, 42, 43, 45, 46, 48, 49, 50, 56, 57:63];
s = 0;
vertices = zeros(4,63); xcoord = zeros(4,63); ycoord = zeros(4,63); centersx = zeros(63,1); centersy = zeros(63,1);
for r = 1:9
    for c = 1:7
        s = s+1;
        vertices(:,s) = [(c-1)+(r-1)*8+1; c+(r-1)*8+1; (c-1)+r*8+1; c+r*8+1];
        xcoord(:,s) = 0.5*[(c-1); c; c; (c-1)];
        ycoord(:,s) = 0.5*[(r-1); (r-1); r; r;];
        centersx(s) = 0.23+0.5*(c-1);
        centersy(s) = 0.26+0.5*(r-1);
    end
end
figu = figure;
Vmax = max(max(V));
V = (V./Vmax)';
fill(xcoord,ycoord,V);
colormap(figu); colorbar;
axis equal
axis off

end