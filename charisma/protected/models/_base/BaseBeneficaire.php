<?php

/**
 * This is the model base class for the table "beneficaire".
 * DO NOT MODIFY THIS FILE! It is automatically generated by giix.
 * If any changes are necessary, you must set or override the required
 * property or method in class "Beneficaire".
 *
 * Columns in table "beneficaire" available as properties of the model,
 * followed by relations of table "beneficaire" available as properties of the model.
 *
 * @property integer $id
 * @property string $photo
 * @property string $firstname
 * @property string $middlename
 * @property string $lastname
 * @property string $dateofbirth
 * @property string $sex
 * @property integer $type
 * @property integer $idmember
 *
 * @property Members $idmember0
 */
abstract class BaseBeneficaire extends GxActiveRecord {

	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public function tableName() {
		return 'beneficaire';
	}

	public static function label($n = 1) {
		return Yii::t('app', 'Dependent|Dependents', $n);
	}

	public static function representingColumn() {
		return 'fullname';
	}

	public function rules() {
		return array(
			array('photo, firstname, lastname, dateofbirth, sex, type, idmember', 'required'),
			array('type, idmember,sex', 'numerical', 'integerOnly'=>true),
			array('photo', 'file','types'=>'jpg, gif, png', 'allowEmpty'=>TRUE, 'on'=>'update'),
			array('firstname, middlename, lastname', 'length', 'max'=>20),
			array('middlename', 'default', 'setOnEmpty' => true, 'value' => null),
			array('id, photo, firstname, middlename, lastname, dateofbirth, sex, type, idmember', 'safe', 'on'=>'search'),
		);
	}

	public function relations() {
		return array(
			'idmember0' => array(self::BELONGS_TO, 'Members', 'idmember'),
		);
	}

    public function getFullName(){

    	return $this->firstname.' '.$this->lastname;
    }
	public function pivotModels() {
		return array(
		);
	}

	public function attributeLabels() {
		return array(
			'id' => Yii::t('app', 'ID'),
			'photo' => Yii::t('app', 'Picture'),
			'firstname' => Yii::t('app', 'Firstname'),
			'middlename' => Yii::t('app', 'Other Names'),
			'lastname' => Yii::t('app', 'Surnames'),
			'dateofbirth' => Yii::t('app', 'Date of Birth'),
			'sex' => Yii::t('app', 'Gender'),
			'type' => Yii::t('app', 'Type'),
			'idmember' => null,
			'idmember0' => null,
		);
	}

	public function search() {
		$criteria = new CDbCriteria;

		$criteria->compare('id', $this->id);
		$criteria->compare('photo', $this->photo, true);
		$criteria->compare('firstname', $this->firstname, true);
		$criteria->compare('middlename', $this->middlename, true);
		$criteria->compare('lastname', $this->lastname, true);
		$criteria->compare('dateofbirth', $this->dateofbirth, true);
		$criteria->compare('sex', $this->sex, true);
		$criteria->compare('type', $this->type);
		$criteria->compare('idmember', $this->idmember);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
		));
	}

static function getSexs()
{
return array(
    array('id'=>'1', 'sex'=>'Female'),
    array('id'=>'0', 'sex'=>'Male'),
);
}
static function getSex($onoff)
{
if($onoff == '0') 
    return 'Male';
else 
    return 'Female';
}

static function getTypes()
{
return array(
    array('id'=>'1', 'type'=>'Conjoint'),
    array('id'=>'2', 'type'=>'Child'),
);
}
static function getType($onoff)
{
if($onoff == 1) 
    return 'Conjoint';
else 
    return 'Child';
}
}