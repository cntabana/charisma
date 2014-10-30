<div class="wide form">

<?php $form = $this->beginWidget('GxActiveForm', array(
	'action' => Yii::app()->createUrl($this->route),
	'method' => 'get',
)); ?>

	<div class="row">
		<?php echo $form->label($model, 'id'); ?>
		<?php echo $form->textField($model, 'id'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'iddrug'); ?>
		<?php echo $form->dropDownList($model, 'iddrug', GxHtml::listDataEx(Drugs::model()->findAllAttributes(null, true)), array('prompt' => Yii::t('app', 'All'))); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'ancient_price'); ?>
		<?php echo $form->textField($model, 'ancient_price'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'new_price'); ?>
		<?php echo $form->textField($model, 'new_price'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'old_changedate'); ?>
		<?php echo $form->textField($model, 'old_changedate', array('maxlength' => 50)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'changedate'); ?>
		<?php echo $form->textField($model, 'changedate'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'userid'); ?>
		<?php echo $form->dropDownList($model, 'userid', GxHtml::listDataEx(Users::model()->findAllAttributes(null, true)), array('prompt' => Yii::t('app', 'All'))); ?>
	</div>

	<div class="row buttons">
		<?php echo GxHtml::submitButton(Yii::t('app', 'Search')); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->
