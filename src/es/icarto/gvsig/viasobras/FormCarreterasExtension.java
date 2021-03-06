package es.icarto.gvsig.viasobras;

import com.iver.andami.PluginServices;
import com.iver.andami.messages.NotificationManager;
import com.iver.andami.plugins.Extension;
import com.iver.cit.gvsig.fmap.layers.FLyrVect;

import es.icarto.gvsig.navtableforms.utils.TOCLayerManager;
import es.icarto.gvsig.viasobras.forms.FormCarreteras;
import es.icarto.gvsig.viasobras.forms.utils.AlphanumericTableLoader;
import es.udc.cartolab.gvsig.users.utils.DBSession;

public class FormCarreterasExtension extends Extension {

    private String carreterasLayerName = "Carreteras";
    public void initialize() {
	registerIcons();
    }

    private void registerIcons() {
	PluginServices.getIconTheme().registerDefault(
		"viasobras-carreteras",
		this.getClass().getClassLoader()
		.getResource("images/carreteras.png"));
    }

    public void execute(String actionCommand) {
	TOCLayerManager toc = new TOCLayerManager();
	FLyrVect l = toc.getLayerByName(carreterasLayerName);
	try {
	    AlphanumericTableLoader.loadTables();
	    if (l != null) {
		FormCarreteras dialog = new FormCarreteras(l);
		if (dialog.init()) {
		    PluginServices.getMDIManager().addWindow(dialog);
		}
	    }
	} catch (Exception e) {
	    NotificationManager.addError(e);
	}
    }

    public boolean isEnabled() {
	TOCLayerManager toc = new TOCLayerManager();
	DBSession dbs = DBSession.getCurrentSession();
	return (dbs != null) && (dbs.getJavaConnection() != null)
		&& (toc.getLayerByName(carreterasLayerName) != null);
    }

    public boolean isVisible() {
	return true;
    }

}
