package gui;

import java.awt.BasicStroke;
import java.awt.Color;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.axis.NumberTickUnit;
import org.jfree.chart.plot.Plot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.XYPlot;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;

/**
 *
 * @author Michal Varga
 */
public class Chart {

    private final JFreeChart aChart;
    
    private final XYSeriesCollection aDataSet;
    private final XYSeries aSeries;
    
    Chart() {
        aSeries = new XYSeries("");
        
        aDataSet = new XYSeriesCollection();
        aDataSet.addSeries(aSeries);
        
        aChart = ChartFactory.createXYStepChart("", // chart title
                                                "", // x
                                                "", // y
                                                aDataSet, // data
                                                PlotOrientation.VERTICAL,
                                                false, // legend            
                                                true, // tooltips
                                                false); // url
        
        XYPlot plot = (XYPlot)aChart.getPlot();        
        plot.setForegroundAlpha(0.5f);
        
        NumberAxis xAxis = new NumberAxis("operation #");
        xAxis.setAutoRange(true);
        xAxis.setTickUnit(new NumberTickUnit(1));
        
        NumberAxis yAxis = new NumberAxis("Size");
        yAxis.setAutoRange(true);
        yAxis.setTickUnit(new NumberTickUnit(1));

        plot.setDomainAxis(xAxis);
        plot.setRangeAxis(yAxis);        
        plot.getRenderer().setSeriesStroke(0, new BasicStroke(3.0f));
        plot.getRendererForDataset(plot.getDataset(0)).setSeriesPaint(0, Color.green); 
    }
    
    public JFreeChart getChart() {
        return aChart;
    }
    
    public void plotSize(int paSize) {
        aSeries.add(aSeries.getItemCount() + 1, paSize);
    }
    
}
