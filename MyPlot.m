function retPlot = MyPlot(x, y)
    %NOTE: Export using export_fig("FileName", "-pdf", "-png", "-transparent")
    if ~isequal(size(x, 1), size(y, 1))
        print("Incompatible Dimensions")
        return
    else
        retPlot = figure();
        hold on;
        % Pixels are 1/96, figure is set to 3.2" x 3.2"
        retPlot.Position = [retPlot.Position(1) retPlot.Position(2) ...
                            291 291];
        for row = 1:size(x, 1) %Assume data is in rows
            plot(x{row, 1}, y{row, 1}, LineWidth = 2)
        end
        xlabel("X Label", ...
                FontWeight="bold", ...
                FontSize=14, ...
                FontName="Times New Roman")
        ylabel("Y Label", ...
                FontWeight="bold", ...
                FontSize=14, ...
                FontName="Times New Roman")
        legend(FontSize=12)
        title("Title", "FontSize", 14, "FontWeight", "bold")
    end
end