package es.icarto.gvsig.viasobras;

import com.iver.andami.plugins.Extension;

import es.icarto.gvsig.viasobras.queries.QueriesPanel;
import es.udc.cartolab.gvsig.users.utils.DBSession;

public class QueriesActuacionsExtension extends Extension {

    public void initialize() {
    }

    public void execute(String actionCommand) {
	QueriesPanel p = new QueriesPanel(false);
	p.open();
    }

    public boolean isEnabled() {
	DBSession dbs = DBSession.getCurrentSession();
	return (dbs != null) && (dbs.getJavaConnection() != null);
    }

    public boolean isVisible() {
	return true;
    }

}
