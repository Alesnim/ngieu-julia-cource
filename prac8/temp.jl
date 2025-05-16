using Plots


y(x, x_1, y_1, x_2, y_2) = x .* (y_2 - y_1) ./ (x_2 - x_1) .- x_1 .* (y_2 - y_1) ./ (x_2 - x_1) .+ y_1;

input = -5:5;
output = y(input, 1, 0, 3, 1);
plot(input,
     output, 
     framestyle=:zerolines,
     label="Equation (1)",
     title="Before Elimination",
     xlim=(-5, 5),
     ylim=(-5, 5),
     linewidth = 3
     );
input = -5:5;
output = y(input, 0, 5.5, 3, 1);
plot!(input,
     output, 
     label="Equation (2)",
     linewidth = 3
     );

scatter!(
(3, 1),
annotations = (3.1, 0.8, Plots.text("Solution", :top, :left)),
marker = 10,
label = false,
)

input = -5:5;
output = y(input, 1, 0, 3, 1);
plot(input,
     output, 
     framestyle=:zerolines,
     label="Equation (1)",
     title="After Elimination",
     xlim=(-5, 5),
     ylim=(-5, 5),
     linewidth = 3
     );
input = -5:5;
output = [1 for i in input];
plot!(input,
     output,
     label="8y = 8",
     linewidth = 3
     );
scatter!(
(3, 1),
annotations = (3.1, 0.8, Plots.text("Solution", :top, :left)),
marker = 10,
label = false,
)
