sets
i Region /Region1*Region5/
j State /NY, AZ, CA, FL, OH, IL, TX, VA, WA, NV,MI/
k Size /Small, Medium, Large/;

Parameters D(j, i), N(j), C(i, k), IR(i);

$call GDXXRW Phase2_Data_OR2.xlsx par=D rng=D!B4:G15 rdim=1 cdim=1
$GDXIN Phase2_Data_OR2.gdx
$load D

$call GDXXRW Phase2_Data_OR2.xlsx par=N rng=N!B3:C14 rdim=1
$GDXIN Phase2_Data_OR2.gdx
$load N

$call GDXXRW Phase2_Data_OR2.xlsx par=C rng=BC!B5:E10 rdim=1 cdim=1
$GDXIN Phase2_Data_OR2.gdx
$load C

$call GDXXRW.exe Phase2_Data_OR2.xlsx par=IR rng=IR!C4:H5 cdim=1
$GDXIN Phase2_Data_OR2.gdx
$load IR

Variables
y(i, k)
x(i, j)
Z;
Binary Variable x;
Binary Variable y;

Equations
ObjectiveFunction
Equation1(j)
Equation2(i)
Equation3(i);

ObjectiveFunction .. Z =e= sum(i,sum(j, x(i, j)*D(j, i)*IR(i)*N(j)))+sum(i, sum(k, C(i, k)*y(i, k))) ;
Equation1(j) .. sum(i, x(i, j))=e=1;
Equation2(i) .. sum(k, y(i, k))=l=1;
Equation3(i) .. sum(j, x(i, j))=l=(2*y(i, 'Small'))+(3*y(i, 'Medium'))+(4*y(i, 'Large'));

Model Problem /all/;

Solve Problem using MIP minimizing Z;

Display  x.l , y.l , Z.l ;

execute_unload "Phase2_Data_OR2.gdx" x.l, y.l, Z.l ;
execute 'gdxxrw Phase2_Data_OR2.gdx var=x.l rng=output!B3'
execute 'gdxxrw Phase2_Data_OR2.gdx var=y.l rng=output!B11'
execute 'gdxxrw Phase2_Data_OR2.gdx var=Z.l rng=output!C18'
