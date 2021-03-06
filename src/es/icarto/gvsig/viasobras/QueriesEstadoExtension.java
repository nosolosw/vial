package es.icarto.gvsig.viasobras;

import com.iver.andami.PluginServices;
import com.iver.andami.plugins.Extension;

import es.icarto.gvsig.viasobras.queries.ui.PanelQueriesEstado;
import es.udc.cartolab.gvsig.users.utils.DBSession;

public class QueriesEstadoExtension extends Extension {

    public void initialize() {
	registerIcons();
    }

    public void execute(String actionCommand) {
	PanelQueriesEstado p = new PanelQueriesEstado();
	p.open();
    }

    public boolean isEnabled() {
	DBSession dbs = DBSession.getCurrentSession();
	return (dbs != null) && (dbs.getJavaConnection() != null);
    }

    public boolean isVisible() {
	return true;
    }

    protected void registerIcons() {
	PluginServices.getIconTheme().registerDefault(
		"viasobras-consultas",
		this.getClass().getClassLoader()
		.getResource("images/consultas.png"));
    }

}
