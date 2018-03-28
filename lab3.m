1.
a)
syms x y;

f(x) = factorial(x);
f(y) = subs(f, x, y);
a = f(10);
disp(['f(10) = ', num2str(double(a))]);

g(y) = 10^y;
h(y) = (g(y) + f(y))/(g(y) - f(y));
rez = subs(h, y, 15);
disp('h(15) = ');
pretty(rez);

disp(['h(15) = ', num2str(round(double(h(15)), 10))]);

b)
f = sym(2^1.5);
pretty(f)

a = single(f);
b = double(f);

disp(['single = ', num2str(a)]);
fprintf('double = %.10f\n', b);

c = b-a;

disp(['razlika = ', num2str(c)]);

2.
syms sigma a d alpha q1 d1 a1 q2
T = [cos(sigma), -cos(alpha)*sin(sigma), sin(alpha)*sin(sigma), a*cos(sigma);...
    sin(sigma), cos(alpha)*cos(sigma), -sin(alpha)*cos(sigma), a*sin(sigma);...
    0, sin(alpha), cos(alpha), d;...
    0, 0, 0, 1]

Ta = subs(T, {sigma, d, a, alpha}, {q1, d1, a1, pi})

Tb = subs(T, {sigma, d, a, alpha}, {q2, 0, a1, 0})
Tc = Ta*Tb;
Tc = simplify(Tc)


Tc = subs(Tc, {q1, q2, a1, d1}, {pi/2, pi/4, 0.3, 0.5})

3.
syms x;
brojnik(x) = 4*x^3 - 7*x^2 - 7*x - 9;
nazivnik(x) = 4*x^4 - 7*x^2 + 3*x -19;

rawnulbrojnik = solve(brojnik);
rawnulnazivnik = solve(nazivnik);

f(x) = brojnik(x)/nazivnik(x);
fd = diff(f);
fdd = diff(fd);


nulnazivnik = double(rawnulnazivnik);
nulbrojnik = double(rawnulbrojnik);

tprekida = [];
index = []
disp('Nultocke nazivnika:');
for ii = 1:length(nulnazivnik)
    if isreal(nulnazivnik(ii))
        tprekida(length(tprekida)+1) = nulnazivnik(ii);
        disp(num2str(nulnazivnik(ii)));
        index(length(index)+1) = ii;
    end
end
ntocke = [];
disp('');
disp('Nultocke brojnika:');
for ii = 1:length(nulbrojnik)
    if isreal(nulbrojnik(ii))
        ntocke(length(ntocke)+1) = nulbrojnik(ii);
        disp(num2str(nulbrojnik(ii)));
    end
end

for ii = 1:length(index)
    lijevi = limit(f, x, rawnulnazivnik(index(ii)), 'left');
    desni = limit(f, x, rawnulnazivnik(index(ii)), 'right');
    disp(['Tocka prekida x = ', num2str(tprekida(ii))]);
    disp(['Lijevi limes', num2str(double(lijevi))]);
    disp(['Desni limes', num2str(double(desni))]);
end

ezplot(fd)
hold on
ezplot(fdd)
ezplot(f)
grid on
legend('prva derivacija', 'druga derivacija', 'funkcija')

plot(ntocke, f(ntocke), 'rx')
for ii = 1:length(tprekida)
    plot(tprekida(ii)*[1 1], [-7 7], 'r--')
end


rawmaxmin = solve(fd);
maxmin = double(rawmaxmin);
for ii = 1:length(maxmin)
    if isreal(maxmin(ii))
        if fdd(maxmin(ii)) > 0
            disp('Minimum:');
            disp(['(' num2str(maxmin(ii)) ',' num2str(double(f(maxmin(ii)))) ')']);
        else
            disp('Maksimum:');
            disp(['(' num2str(maxmin(ii)) ',' num2str(double(f(maxmin(ii)))) ')']);
        end
    end
end

p = double(int(f, x, [-1, 1]));
disp(['Povrsina ispod funkcije u intervalu [-1 1] je ' num2str(p)])
