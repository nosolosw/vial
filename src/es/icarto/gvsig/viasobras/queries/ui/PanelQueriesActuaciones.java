package es.icarto.gvsig.viasobras.queries.ui;

import javax.swing.JScrollPane;

import com.jeta.forms.components.panel.FormPanel;


@SuppressWarnings("serial")
public class PanelQueriesActuaciones extends gvWindow {

    private FormPanel form;

    public PanelQueriesActuaciones(boolean b) {
	super(460, 620, true);
	form = new FormPanel("consultas-actuaciones-ui.xml");
	JScrollPane scrolledForm = new JScrollPane(form);
	this.add(scrolledForm);
    }

}