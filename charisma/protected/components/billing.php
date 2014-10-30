<?php


class MyActiveDataProvider extends CActiveDataProvider {

    public function bill_invoice() {
        
        $criteria=new CDbCriteria;       
        $criteria->select=array('price,quantity,idinvoice,idmedical,id,(price*1) insurencePrice');
        $criteria->addCondition('idinvoice='.$_GET['idinvoice']);
	    
	    return new MyActiveDataProvider($this, array(
			'criteria' => $criteria,
		));



	}

}
?>