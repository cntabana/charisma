<?php

Yii::import('application.models._base.BaseDrugs');

class Drugs extends BaseDrugs
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}