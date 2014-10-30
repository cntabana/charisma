<?php

Yii::import('application.models._base.BaseDoctors');

class Doctors extends BaseDoctors
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}