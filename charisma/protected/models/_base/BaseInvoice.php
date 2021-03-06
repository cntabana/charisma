<?php

/**
 * This is the model base class for the table "invoice".
 * DO NOT MODIFY THIS FILE! It is automatically generated by giix.
 * If any changes are necessary, you must set or override the required
 * property or method in class "Invoice".
 *
 * Columns in table "invoice" available as properties of the model,
 * followed by relations of table "invoice" available as properties of the model.
 *
 * @property integer $id
 * @property string $date
 * @property integer $idmember
 * @property integer $idhospital
 * @property integer $status
 * @property integer $type
 *
 * @property BillingDetails[] $billingDetails
 * @property BillingDrug[] $billingDrugs
 * @property Hospital $idhospital0
 * @property Members $idmember0
 * @property Ordonance[] $ordonances
 */
abstract class BaseInvoice extends GxActiveRecord {

	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public function tableName() {
		return 'invoice';
	}

	public static function label($n = 1) {
		return Yii::t('app', 'Invoice No|Invoices', $n);
	}

	public static function representingColumn() {
		return 'id';
	}

	public function rules() {
		return array(
			array('date, idmember, idhospital, status, type', 'required'),
			array('idmember, idhospital, status, type', 'numerical', 'integerOnly'=>true),
			array('id, date, idmember, idhospital, status, type', 'safe', 'on'=>'search'),
		);
	}

	public function relations() {
		return array(
			'billingDetails' => array(self::HAS_MANY, 'BillingDetails', 'idinvoice'),
			'billingDrugs' => array(self::HAS_MANY, 'BillingDrug', 'idinvoice'),
			'idhospital0' => array(self::BELONGS_TO, 'Hospital', 'idhospital'),
			'idmember0' => array(self::BELONGS_TO, 'Members', 'idmember'),
			'ordonances' => array(self::HAS_MANY, 'Ordonance', 'idinvoice'),
		);
	}

	public function pivotModels() {
		return array(
		);
	}

	public function attributeLabels() {
		return array(
			'id' => Yii::t('app', 'ID'),
			'date' => Yii::t('app', 'Date'),
			'idmember' => null,
			'idhospital' => null,
			'status' => Yii::t('app', 'Status'),
			'type' => Yii::t('app', 'Type'),
			'billingDetails' => null,
			'billingDrugs' => null,
			'idhospital0' => null,
			'idmember0' => null,
			'ordonances' => null,
		);
	}

	public function search() {
		$criteria = new CDbCriteria;
       
        if(Yii::app()->user->groupe==2){

        	 $criteria->addCondition('type=4');
        }
         if(Yii::app()->user->groupe==1){

        	 $criteria->addCondition('type!=4');
        }
         if(Yii::app()->user->groupe==6){

        	 $criteria->addCondition('type=4');
        }
       
		$criteria->compare('id', $this->id);
		$criteria->compare('date', $this->date, true);
		$criteria->compare('idmember', $this->idmember);
		$criteria->compare('idhospital', $this->idhospital);
		$criteria->compare('status', $this->status);
		$criteria->compare('type', $this->type);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
		));
	}

static function getTypes()
{
return array(
    array('id'=>'1', 'type'=>'Analyse'),
    array('id'=>'2', 'type'=>'Traitement'),
    array('id'=>'3', 'type'=>'Lunette'),
    array('id'=>'4', 'type'=>'Pharmacy'),
);
}
static function getType($onoff)
{
if($onoff == 1) 
    return 'Analyse';
else if($onoff == 2)
    return 'Traitement';

else  if($onoff == 3)
    return 'Lunette';
else
	return 'Pharmacy';
}



}