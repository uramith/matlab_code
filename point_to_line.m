function short_dist = point_to_line(pt, v1, v2)

      a = v1 - v2;

      b = pt - v2;

      short_dist = norm(cross(a,b)) / norm(a);
end