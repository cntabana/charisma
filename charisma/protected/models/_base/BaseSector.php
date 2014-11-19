<?php

/**
 * This is the model base class for the table "sector".
 * DO NOT MODIFY THIS FILE! It is automatically generated by giix.
 * If any changes are necessary, you must set or override the required
 * property or method in class "Sector".
 *
 * Columns in table "sector" available as properties of the model,
 * followed by relations of table "sector" available as properties of the model.
 *
 * @property integer $id
 * @property string $umurenge
 * @property integer $iddistrict
 *
 * @property District $iddistrict0
 */
abstract class BaseSector extends GxActiveRecord {

	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public function tableName() {
		return 'sector';
	}

	public static function label($n = 1) {
		return Yii::t('app', 'Department|Departments', $n);
	}

	public static function representingColumn() {
		return 'sector';
	}

	public function rules() {
		return array(
			array('sector, iddistrict', 'required'),
			array('iddistrict', 'numerical', 'integerOnly'=>true),
			array('sector', 'length', 'max'=>30),
			array('id, sector, iddistrict', 'safe', 'on'=>'search'),
		);
	}

	public function relations() {
		return array(
			'iddistrict0' => array(self::BELONGS_TO, 'District', 'iddistrict'),
		);
	}

	public function pivotModels() {
		return array(
		);
	}

	public function attributeLabels() {
		return array(
			'id' => Yii::t('app', 'ID'),
			'sector' => Yii::t('app', 'Department'),
			'iddistrict' => null,
			'iddistrict0' => null,
		);
	}

	public function search() {
		$criteria = new CDbCriteria;

		$criteria->compare('id', $this->id);
		$criteria->compare('sector', $this->sector, true);
		$criteria->compare('iddistrict', $this->iddistrict);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
		));
	}
}