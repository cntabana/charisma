<?php

/**
 * This is the model class for table "members".
 *
 * The followings are the available columns in table 'members':
 * @property integer $id
 * @property string $cardnumber
 * @property string $firstname
 * @property string $middlename
 * @property string $lastname
 * @property string $issuedate
 * @property string $expireddate
 * @property string $birthday
 * @property string $sex
 * @property string $phonenumber
 * @property string $address
 * @property string $email
 * @property integer $iddistrict
 * @property integer $idsector
 * @property string $nationality
 * @property integer $status
 * @property integer $type
 * @property string $photo
 * @property string $title
 *
 * The followings are the available model relations:
 * @property Beneficaire[] $beneficaires
 * @property Invoice[] $invoices
 * @property District $iddistrict0
 * @property Sector $idsector0
 */
class MembersBoot extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'members';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('cardnumber, middlename, lastname, issuedate, expireddate, birthday, sex, iddistrict, idsector, status, type, photo, title', 'required'),
			array('iddistrict, idsector, status, type', 'numerical', 'integerOnly'=>true),
			array('cardnumber', 'length', 'max'=>15),
			array('firstname, middlename, lastname, phonenumber', 'length', 'max'=>20),
			array('sex', 'length', 'max'=>1),
			array('address', 'length', 'max'=>30),
			array('email, photo', 'length', 'max'=>50),
			array('nationality', 'length', 'max'=>40),
			array('title', 'length', 'max'=>7),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, cardnumber, firstname, middlename, lastname, issuedate, expireddate, birthday, sex, phonenumber, address, email, iddistrict, idsector, nationality, status, type, photo, title', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'beneficaires' => array(self::HAS_MANY, 'Beneficaire', 'idmember'),
			'invoices' => array(self::HAS_MANY, 'Invoice', 'idmember'),
			'iddistrict0' => array(self::BELONGS_TO, 'District', 'iddistrict'),
			'idsector0' => array(self::BELONGS_TO, 'Sector', 'idsector'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'cardnumber' => 'Membership Card',
			'firstname' => 'Firstname',
			'middlename' => 'Other Name',
			'lastname' => 'Surname',
			'issuedate' => 'Card Issue Date',
			'expireddate' => 'Card Expire Date',
			'birthday' => 'Birthday',
			'sex' => 'Gender',
			'phonenumber' => 'Phonenumber',
			'address' => 'Address',
			'email' => 'Email',
			'iddistrict' => 'District',
			'idsector' => 'Sector',
			'nationality' => 'Nationality',
			'status' => 'Status',
			'type' => 'Type',
			'photo' => 'Photo',
			'title' => 'Title',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 *
	 * Typical usecase:
	 * - Initialize the model fields with values from filter form.
	 * - Execute this method to get CActiveDataProvider instance which will filter
	 * models according to data in model fields.
	 * - Pass data provider to CGridView, CListView or any similar widget.
	 *
	 * @return CActiveDataProvider the data provider that can return the models
	 * based on the search/filter conditions.
	 */
	public function search()
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id',$this->id);
		$criteria->compare('cardnumber',$this->cardnumber,true);
		$criteria->compare('firstname',$this->firstname,true);
		$criteria->compare('middlename',$this->middlename,true);
		$criteria->compare('lastname',$this->lastname,true);
		$criteria->compare('issuedate',$this->issuedate,true);
		$criteria->compare('expireddate',$this->expireddate,true);
		$criteria->compare('birthday',$this->birthday,true);
		$criteria->compare('sex',$this->sex,true);
		$criteria->compare('phonenumber',$this->phonenumber,true);
		$criteria->compare('address',$this->address,true);
		$criteria->compare('email',$this->email,true);
		$criteria->compare('iddistrict',$this->iddistrict);
		$criteria->compare('idsector',$this->idsector);
		$criteria->compare('nationality',$this->nationality,true);
		$criteria->compare('status',$this->status);
		$criteria->compare('type',$this->type);
		$criteria->compare('photo',$this->photo,true);
		$criteria->compare('title',$this->title,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return MembersBoot the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
static function getGender(){

	$gender = array(
      array('value' => 0, 'text' => 'Male'),
      array('value' => 1, 'text' => 'Female'),
      
    );

    return $gender;
}
	

static function getType(){

	$type = array(
     array('value'=>'1', 'text'=>'Staff'),
    array('value'=>'0', 'text'=>'Student'),
      
    );

    return $type;
}

static function getStatus(){

	$status = array(
      array('value'=>'1', 'text'=>'Active'),
    array('value'=>'0', 'text'=>'Inactive'),
    );

    return $status;
}
}
