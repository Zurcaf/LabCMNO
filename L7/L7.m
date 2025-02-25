G = eye(size(A));
Qe = eye(size(A))*10;
Re = eye(2);

L = lqe(A, G, C, Qe, Re);

disp(L);
