<?php

/**
 * This is the model base class for the table "service".
 * DO NOT MODIFY THIS FILE! It is automatically generated by giix.
 * If any changes are necessary, you must set or override the required
 * property or method in class "Service".
 *
 * Columns in table "service" available as properties of the model,
 * followed by relations of table "service" available as properties of the model.
 *
 * @property integer $id
 * @property string $service
 *
 * @property Traitement[] $traitements
 */
abstract class BaseService extends GxActiveRecord {

	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public function tableName() {
		return 'service';
	}

	public static function label($n = 1) {
		return Yii::t('app', 'Service|Services', $n);
	}

	public static function representingColumn() {
		return 'service';
	}

	public function rules() {
		return array(
			array('service', 'required'),
			array('service', 'length', 'max'=>50),
			array('id, service', 'safe', 'on'=>'search'),
		);
	}

	public function relations() {
		return array(
			'traitements' => array(self::HAS_MANY, 'Traitement', 'idservice'),
		);
	}

	public function pivotModels() {
		return array(
		);
	}

	public function attributeLabels() {
		return array(
			'id' => Yii::t('app', 'ID'),
			'service' => Yii::t('app', 'Service'),
			'traitements' => null,
		);
	}

	public function search() {
		$criteria = new CDbCriteria;

		$criteria->compare('id', $this->id);
		$criteria->compare('service', $this->service, true);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
		));
	}
}