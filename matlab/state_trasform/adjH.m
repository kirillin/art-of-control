function Ad = adjH(H)
    R = H(1:3, 1:3);
    p = H(1:3, 4);
    Ad = [
        R,            zeros(size(R));
        skew(p) * R,     R
    ];
%     Ad = [
%         R,            skew(p) * R;
%         zeros(size(R)),     R
%     ];
end

