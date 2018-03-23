1.
x = linspace(-5, 5);
y = linspace(2, 4);
[X, Y] = meshgrid(x, y);
z = (sin(X))./((cos(Y) + 1.1) .* exp(0.05.*(X.^2 + Y.^2)));
mesh(X, Y, z);

2.
a)
m = 6;
xi = [1 2 2.5 4 4.6 5];

min = xi(1);
max = xi(m);
srednja = mean(xi);
raspon = 2 * (max - min);

minrazmak = xi(2) - xi(1);
for k = 2:(m-1)
    if minrazmak > (xi(k+1)-xi(k))
        minrazmak = (xi(k+1) - xi(k));
    end
end
razmak = minrazmak/10;

vi = [srednja - raspon/2: razmak: srednja + raspon/2]


yi = sin(xi);
P = polyfit(xi, yi, 3);
h = polyval(P, vi);

subplot(211)
grid on
hold on
plot(vi, h, 'g')
plot(vi, sin(vi), 'b--')
plot(xi, sin(xi), 'rx')
legend('P(x)', 'f(x)', '(x_i,f(x_i))')
ylabel('f(x),P(x)')

e = sin(vi) - h;
subplot(212)
grid on
hold on
plot(vi, e, 'b')
ylabel('e(x) = f(x) - P(x)')

b)
function polinom = polinom_approx(tocke, crtanje)
    m = length(tocke);
   
    min = tocke(1);
    max = tocke(m);
    srednja = mean(tocke);
    raspon = 2 * (max - min);
   
    minrazmak = tocke(2) - tocke(1);
    for k = 2:(m-1)
        if minrazmak > (tocke(k+1)-tocke(k))
            minrazmak = (tocke(k+1) - tocke(k));
        end
    end
    razmak = minrazmak/10;
   
    vi = [srednja - raspon/2: razmak: srednja + raspon/2];
   
   
    yi = sin(tocke);
    polinom = polyfit(tocke, yi, 3);
    h = polyval(polinom, vi);
   
    if crtanje ~= 0
        subplot(211)
        grid on
        hold on
        plot(vi, h, 'g')
        plot(vi, sin(vi), 'b--')
        plot(tocke, sin(tocke), 'rx')
        legend('P(x)', 'f(x)', '(x_i,f(x_i))')
        ylabel('f(x),P(x)')
       
        e = sin(vi) - h;
        subplot(212)
        grid on
        hold on
        plot(vi, e, 'b')
        ylabel('e(x) = f(x) - P(x)')
    end

end

3.
function [N, indeks] = ObradaImenika(Podatak, Operacija)
    global Imenik
   
    if nargin ~= 2
        error('Funkcija prima 2 ulazna argumenta!')
    end;
   
    if ~ischar(Podatak)
        error('Podatak nije string!')
    end
   
   
   
    if Operacija == 1
        indeks = find(strcmp(Podatak, Imenik));
        if isempty(indeks)
            Imenik(end+1,:) = {Podatak,1};
        else
            Imenik{indeks, 2} = Imenik{indeks, 2} + 1;
        end
           
    elseif Operacija == 0
        indeks = find(strcmp(Podatak, Imenik));
        if isempty(indeks)
            error('Podatak ne postoji!')
        else
            Imenik(indeks, :) = [];
        end
           
    else
        error('Zadana Operacija nije 0 ili 1!')
    end
   
   
   
    [M, Y] = size(Imenik);
    N = 0;
    for ii = 1:M
        if Imenik{ii, 2} >= 1
            N = N+1;
        end
    end
   
