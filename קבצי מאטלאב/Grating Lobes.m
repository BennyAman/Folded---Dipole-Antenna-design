dipole_array.NumElements = 9;
dipole_array.ElementSpacing = lambda/2;
D_half_lambda = pattern(dipole_array,freq,az_angle,0,'CoordinateSystem','rectangular');
dipole_array.ElementSpacing = 0.75*lambda;
D_three_quarter_lambda = pattern(dipole_array,freq,az_angle,0,'CoordinateSystem','rectangular');
dipole_array.ElementSpacing = 1.5*lambda;
D_lambda = pattern(dipole_array,freq,az_angle,0,'CoordinateSystem','rectangular');
patterngrating1 = figure;
plot(az_angle,D_half_lambda,az_angle,D_three_quarter_lambda,az_angle,D_lambda,'LineWidth',1.5);
grid on
xlabel('Azimuth (deg)')
ylabel('Directivity (dBi)')
title('Array Pattern (Elevation = 0 deg)')
legend('d=\lambda/2','d=0.75\lambda','d=1.5\lambda','Location','best')