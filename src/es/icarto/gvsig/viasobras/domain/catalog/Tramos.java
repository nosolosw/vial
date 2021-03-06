package es.icarto.gvsig.viasobras.domain.catalog;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import javax.swing.table.TableModel;

import es.icarto.gvsig.viasobras.domain.catalog.mappers.TramosMapper;
import es.icarto.gvsig.viasobras.domain.catalog.utils.TramosComparator;
import es.icarto.gvsig.viasobras.domain.catalog.utils.TramosTableModel;
import es.icarto.gvsig.viasobras.domain.catalog.validation.TramoValidator;

public class Tramos implements Iterable<Tramo> {

    private TableModel tm;
    private List<Tramo> tramos;
    private List<Tramo> tramosToValidate;
    private TramosMapper mapper;
    private TramoValidator tramoValidator;

    public Tramos(TramosMapper mapper, List<Tramo> tramos) {
	this.mapper = mapper;
	this.tramos = tramos;
	Collections.sort(this.tramos, new TramosComparator());
	this.tm = new TramosTableModel(this);
	this.tramoValidator = new TramoValidator();
	this.tramosToValidate = new ArrayList<Tramo>();
    }

    public TableModel getTableModel() {
	return this.tm;
    }

    public int size() {
	return this.tramos.size();
    }

    /**
     * Get tramo as it is ordered in the tramos list
     * 
     * @param index
     * @return
     */
    public Tramo getFromList(int index) {
	return tramos.get(index);
    }

    public void removeFromList(int index) {
	tramos.remove(index);
    }

    public Tramos save() throws SQLException {
	tramosToValidate.clear();
	return mapper.save(this);
    }

    public Iterator<Tramo> iterator() {
	return tramos.iterator();
    }

    public int addTramo(Tramo tramo) {
	tramo.setStatus(Tramo.STATUS_INSERT);
	if (tramo.getId() == Tramo.NO_GID) {
	    // as we don't know what is the next ID in source, just create a
	    // random one. It will be ignored as INSERT queries should be leave
	    // the id blank for the DB to autocalculate
	    tramo.setId("virtual-" + tramos.size() + "-"
		    + Double.toString(Math.random()));
	}
	tramos.add(tramo);
	tramosToValidate.add(tramo);
	return tramos.size() - 1;
    }

    public boolean removeTramo(String id) {
	// remove it from tramos to validate
	Tramo tramo = this.getTramo(id);
	if (tramosToValidate.contains(tramo)) {
	    tramosToValidate.remove(tramo);
	}
	// update status
	if (id.equals(Tramo.NO_GID)) {
	    return false;
	} else {
	    for (Tramo t : tramos) {
		if (t.getId().equals(id)) {
		    t.setStatus(Tramo.STATUS_DELETE);
		    return true;
		}
	    }
	    return false;
	}
    }

    public boolean updateTramo(String id, int propertyIndex,
	    Object propertyValue) {
	Tramo t = this.getTramo(id);
	if (t.setProperty(propertyIndex, propertyValue)) {
	    int status = t.getStatus();
	    if ((status == Tramo.STATUS_ORIGINAL)
		    || (status == Tramo.STATUS_UPDATE)) {
		// if tramo has INSERT status we should not set as UPDATE,
		// as it will affect how mapper will process it
		this.getTramo(id).setStatus(Tramo.STATUS_UPDATE);
	    }
	    tramosToValidate.add(t);
	    return true;
	}
	return false;
    }

    private Tramo getTramo(String id) {
	for (Tramo t : tramos) {
	    if (t.getId().equals(id)) {
		return t;
	    }
	}
	return null;
    }

    public boolean canSaveTramos() {
	if (tramosToValidate.size() == 0) {
	    return true;
	}
	for (Tramo t : tramosToValidate) {
	    if (!tramoValidator.validate(t)) {
		return false;
	    }
	}
	return true;
    }

}
